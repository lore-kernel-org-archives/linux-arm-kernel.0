From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 5 Dec 2012 08:38:07 +0530
Subject: [PATCH v2] ARM: DTS: CROS5250: Add max77686 device tree support
In-Reply-To: <CAD=FV=VRPwuaOJrjGvtWzRQfb=NYsmP9Vfyk8jsxTMTv=6Pa7A@mail.gmail.com>
References: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
 <1354627096-9433-1-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=VRPwuaOJrjGvtWzRQfb=NYsmP9Vfyk8jsxTMTv=6Pa7A@mail.gmail.com>
Message-ID: <CAM4voak90pjZkGGY=gyc=+zNXRu_kUOjhqUM106OnfhLfa5hHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

[...]
>> +
>> +                               ldo7_reg: LDO7 {
>> +                                       regulator-name = "P1.0V_LDO_OUT7";
>> +                                       regulator-min-microvolt = <1100000>;
>> +                                       regulator-max-microvolt = <1100000>;
>> +                                       regulator-always-on;
>> +                               };
>
> This matches the signal name on the most recent schematics, which is
> good, but I'd be slightly happier if it said "1.1V" in instead of
> 1.0V.  I'd imagine that if we ever rev the schematics that we'd fix
> that.
Will change to 1.1
[...]
> ...would love to see LDO7 name fixed up, but otherwise looks good to
> me.  Thanks!
>
> Acked-by: Doug Anderson <dianders@chromium.org>
Will re-post with your ACK.

Abhilash
