From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 23 Jan 2017 20:24:47 +0300
Subject: [PATCH v4 0/9] Implement clocksource for rockchip SoC using
 rockchip timer
In-Reply-To: <1793912.WfGyM7qEjy@diego>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <E6DD9335-0D2D-47CB-8098-5F96C2E08139@gmail.com> <20170123144744.GE2166@mai>
 <1793912.WfGyM7qEjy@diego>
Message-ID: <58B283B0-02F6-4342-A6D2-7E082E04863E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko, Daniel, thanks a lot for review!
I?ll send v5 series this week.

Heiko, Daniel, may I add 'Reviewed-by:? to patch series?

Reviewed-by: Heiko St?bner <heiko@sntech.de> ?
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org> ?

Regards,
Alexander.

> 23 ???. 2017 ?., ? 20:12, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> Am Montag, 23. Januar 2017, 15:47:44 CET schrieb Daniel Lezcano:
>> On Wed, Dec 21, 2016 at 05:21:05PM +0300, Alexander Kochetkov wrote:
>>> Hello Heiko, Daniel!
>>> 
>>> Are there any reasons why the patches [1][2] are not applied yet into
>>> kernel? How can I help in applying patches?
>> 
>> Hi Alexander,
>> 
>> sorry for the delay. Let me review them before taking the patchset.
>> 
>> Heiko, can you have a look to them also ?
> 
> somehow this series moved down to much in my inbox, sorry.
> 
> Devicetree changes look good, except where I commented.
> I guess it would be best (least intrusive) if I queue up the (then fixed) 
> devicetree changes after you are satisfied with the code parts.
> 
> I've also looked over the code changes again, test-build them and found the 
> build error mentioned separately. Overall they look good though.
> 
> 
> Heiko
