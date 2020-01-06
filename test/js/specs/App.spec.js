import { mount } from '@vue/test-utils'
import App from '../../../app/javascript/app.vue'

describe('app.vue', () => {
  it('should render correct contents', () => {
    expect(mount(App).find('button').text())
      .to.equal('Search')
  })
})
