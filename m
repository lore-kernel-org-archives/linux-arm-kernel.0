From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 24 Mar 2017 14:02:38 +0530
Subject: [PATCH 07/12] ARM: dts: imx6ul-isiot: Add Sound card with codec
 node
In-Reply-To: <20170324052324.GF30608@dragon>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
 <1490204897-14525-8-git-send-email-jagan@openedev.com>
 <20170324052324.GF30608@dragon>
Message-ID: <CAMty3ZBSVgL==LsCzsODkL117WFL4Pv4kwhXhxc3wDWre3i-zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 10:53 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 11:18:12PM +0530, Jagan Teki wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Add support for Sound card and related codec(via i2c1) nodes
>> on Engicam Is.IoT MX6UL variant module boards.
>>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 11 +++++++++++
>>  arch/arm/boot/dts/imx6ul-isiot.dtsi        | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
>> index b149b5e..c79fa42 100644
>> --- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
>> +++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
>> @@ -41,6 +41,17 @@
>>   */
>>
>>  &i2c1 {
>> +     codec: sgtl5000 at 0a {
>
>         sgtl5000: codec at a {

Just to understand, why codec: sgtl5000 at 0a not a suitable notation?
couldn't see any Documentation.

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
