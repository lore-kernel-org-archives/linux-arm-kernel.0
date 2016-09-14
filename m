From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 14 Sep 2016 23:13:37 +0530
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
Message-ID: <CAMty3ZDKrXxmwDFxSBvL_anJQPdXEfnJ40uNv5B6KssQyJJKhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 4:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Sep 11, 2016 at 3:30 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>
>> +       reg_3p3v: regulator-3p3v {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "3P3V";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-boot-on;
>> +               regulator-always-on;
>
> You should remove " regulator-boot-on" and "regulator-always-on" as
> the reg_3p3v regulator is controlled by the can nodes.

OK, but where it showed on the processor manual? I only find LDO_2P5
regulator which is connected to high speed devices, HDMI, SATA etc on
Figure 50-1: Power system overview

thanks!
-- 
Jagan Teki
Free Software Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
