From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 28 Feb 2012 18:04:32 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <CAJOA=zNjhKp29Or9WT1bw5R44f7zGZnpo35Xxcg80n8QGOO09A@mail.gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zNZ2xh34DTZc1gJwy0O6d=E=wdP4_sq_zrj3qjLcbj0kw@mail.gmail.com>
 <CAMXH7KFbH2HFwFgMu+XfrFKSEGTvD_H09EN2atHUJa9pz7ESYg@mail.gmail.com>
 <CAJOA=zPpptmXFKpmgA_bT+jCr2hv5tfW+xaPnocc6oXk=cpidw@mail.gmail.com>
 <CAMXH7KFz18Wv=RYvbww3OqBspbP3L0UqLmuiJ7q8c6vyYv2b2Q@mail.gmail.com>
 <CAJOA=zNjhKp29Or9WT1bw5R44f7zGZnpo35Xxcg80n8QGOO09A@mail.gmail.com>
Message-ID: <CAMXH7KFX9M+i+vFBECdyoYX+V+NmgHmwdeNCyZhLdaC8dSX0EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Sounds reasonable. ?In some cases it may be helpful to track state
>> demotion as well. ?Since I'm still a noob and wearing my submission
>> training wheels, I'm trying to minimize things that fall outside of
>> this basic consolidation effort for this patch series. ?But I added
>> Jon's suggestion to this cpuidle page which contains future cpuidle
>> items to consider adding:
>> https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/CPUIdle#Track_both_attempted_and_successful_enter_attempts
>
> Yeah, I don't want to feature-bloat your submission more than
> necessary. ?I'm happy for the usage counter stuff to get tackled at a
> later date, but you're still on board for setting last_residency to
> zero in this series, right?

Yes.

>
> Regards,
> Mike
>
