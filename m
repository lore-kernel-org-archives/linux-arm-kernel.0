From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 31 May 2011 09:22:55 +0530
Subject: [PATCH 0/3] SPEAr320: Add pwm support
In-Reply-To: <201105301453.40314.arnd@arndb.de>
References: <cover.1306739836.git.viresh.kumar@st.com>
	<201105301352.55570.arnd@arndb.de> <4DE38616.7050901@st.com>
	<201105301453.40314.arnd@arndb.de>
Message-ID: <4DE46617.2000505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2011 06:23 PM, Arnd Bergmann wrote:
>> > Obviously this can be done, but as it has already taken too long for that
>> > framework to get added in mainline, and still we don't know how much more
>> > time it will take. I would suggest to push this patchset now. And i
>> > will update this accordingly once that framework comes up.
> Ok, makes sense.
> 
> How about starting a drivers/pwm directory though? I think we have
> broad support for the idea of moving drivers into their subsystems,
> so even if you don't change the code, I think it would be a better
> place than drivers/misc.

Ya, i can easily do it. I didn't do it earlier, because i thought people
might ask me to provide framework with it too. New folder with only my driver
as part of it might not be accepted. If nobody have any issues with it
i can send patch with required changes.

One more thing: Who will push drivers/pwm now?
@Andrew: Will that be you??

-- 
viresh
