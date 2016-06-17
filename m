From: lkp@intel.com (kbuild test robot)
Date: Sat, 18 Jun 2016 00:32:19 +0800
Subject: [PATCH 4/4] ARM: dts: Add WP8548 based MangOH Green board DTS
In-Reply-To: <1466160132-24574-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <201606180024.RRX9R7Xz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc3 next-20160617]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/dt-bindings-vendor-prefixes-Add-Sierra-Wireless/20160617-185152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/swi-wp8548-mangoh-green.dts:48:0:
>> arch/arm/boot/dts/swi-wp8548.dtsi:46:29: fatal error: qcom-mdm9615.dtsi: No such file or directory
   compilation terminated.

vim +46 arch/arm/boot/dts/swi-wp8548.dtsi

bb4ea607 Neil Armstrong 2016-06-17  30   *     Software is furnished to do so, subject to the following
bb4ea607 Neil Armstrong 2016-06-17  31   *     conditions:
bb4ea607 Neil Armstrong 2016-06-17  32   *
bb4ea607 Neil Armstrong 2016-06-17  33   *     The above copyright notice and this permission notice shall be
bb4ea607 Neil Armstrong 2016-06-17  34   *     included in all copies or substantial portions of the Software.
bb4ea607 Neil Armstrong 2016-06-17  35   *
bb4ea607 Neil Armstrong 2016-06-17  36   *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
bb4ea607 Neil Armstrong 2016-06-17  37   *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
bb4ea607 Neil Armstrong 2016-06-17  38   *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
bb4ea607 Neil Armstrong 2016-06-17  39   *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
bb4ea607 Neil Armstrong 2016-06-17  40   *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
bb4ea607 Neil Armstrong 2016-06-17  41   *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
bb4ea607 Neil Armstrong 2016-06-17  42   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
bb4ea607 Neil Armstrong 2016-06-17  43   *     OTHER DEALINGS IN THE SOFTWARE.
bb4ea607 Neil Armstrong 2016-06-17  44   */
bb4ea607 Neil Armstrong 2016-06-17  45  
bb4ea607 Neil Armstrong 2016-06-17 @46  #include "qcom-mdm9615.dtsi"
bb4ea607 Neil Armstrong 2016-06-17  47  
bb4ea607 Neil Armstrong 2016-06-17  48  / {
bb4ea607 Neil Armstrong 2016-06-17  49  	model = "Sierra Wireless WP8548 Module";
bb4ea607 Neil Armstrong 2016-06-17  50  	compatible = "swi,wp8548", "qcom,mdm9615";
bb4ea607 Neil Armstrong 2016-06-17  51  
bb4ea607 Neil Armstrong 2016-06-17  52  	memory {
bb4ea607 Neil Armstrong 2016-06-17  53  		reg = <0x48000000 0x7F00000>;
bb4ea607 Neil Armstrong 2016-06-17  54  	};

:::::: The code at line 46 was first introduced by commit
:::::: bb4ea607e58ad6fc8b4a11295a455ba2bbe9dced ARM: dts: Add Sierra Wireless WP8548 dtsi

:::::: TO: Neil Armstrong <narmstrong@baylibre.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/1e522d69/attachment-0001.obj>
