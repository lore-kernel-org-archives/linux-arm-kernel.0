From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 24 Jan 2013 14:52:05 +0530
Subject: [PATCH] ARM: DTS: exynos5250-arndale: Add initial board support
 file
In-Reply-To: <CAGOxZ53VsXE_as6aNk85jdxVG2FAg-SqWc8svTHpgrcttE_q0w@mail.gmail.com>
References: <1359008188-23395-1-git-send-email-tushar.behera@linaro.org>
 <CAGOxZ53VsXE_as6aNk85jdxVG2FAg-SqWc8svTHpgrcttE_q0w@mail.gmail.com>
Message-ID: <5100FD3D.7080206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 12:21 PM, Alim Akhtar wrote:

>> +
>> +       i2c at 12CC0000 {
>> +               status = "disabled";
>> +       };
>> +
>> +       i2c at 12CD0000 {
>> +               status = "disabled";
>> +       };
>> +
>> +       i2c at 121D0000 {
>> +               status = "disabled";
>> +       };
>> +
> 
> Why to disable these i2c devices here? Any particular reason?
> You can moves these to exynos5250.dtsi which is suppose to be common
> for all the exynos5250 platforms.
> Please see the exynos4.dtsi for reference.
> 

Agreed. There was a discussion going on in [1] related to this. Since
there was no consensus on that, I preferred to go with the current
approach that is followed for other EXYNOS5250 based scripts.

If it is agreed by Kukjin to move to Exynos4 style, then I can submit
patches for that.

[1]
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15013.html

-- 
Tushar Behera
