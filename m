From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Sun, 15 Dec 2013 22:38:07 +0900
Subject: [RFC v2 1/4] power: asv: Add common ASV support for Samsung SoCs
In-Reply-To: <CAM4voam5GS5HORbb_r57C_61cMafKjQnBnR0dxD7x-9iTBps8Q@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
 <1384515691-26299-2-git-send-email-sachin.kamat@linaro.org>
 <CAM4voam5GS5HORbb_r57C_61cMafKjQnBnR0dxD7x-9iTBps8Q@mail.gmail.com>
Message-ID: <CAKew6eVieLHyzQ38-Dm-dRh_P0e9wv+kEu5xCsBWgSq_-gQNBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

[ ... ]
>> + * @nr_dvfs_level: Number of dvfs levels supported by member.
>> + * @dvfs_table: Table containing supported ASV freqs and corresponding volts.
>> + * @asv_grp: ASV group of member.
>> + * @flags: ASV flags
> What are the ASV flags you had in mind ?

Right now we don't have any, some thing like delayed
init of asv table depending upon dev_node/user(instance)
was coming in my mind.
Actually I missed to remove it for the time being.

Thanks for your review and other suggestions.

Regards,
Yadwinder
