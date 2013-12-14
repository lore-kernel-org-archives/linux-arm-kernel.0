From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Sat, 14 Dec 2013 09:32:36 +0100
Subject: [PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files
In-Reply-To: <20131213190707.GA9713@roeck-us.net>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>
 <1386945188-8316-2-git-send-email-jonas.jensen@gmail.com>
 <201312131717.25435.arnd@arndb.de>
 <CACmBeS0Uz+Z=MsqvXburO1swCdyGvEXHhfs8M7ZnMMKBNJjG1A@mail.gmail.com>
 <20131213190707.GA9713@roeck-us.net>
Message-ID: <CACmBeS2_WZj6_HJo0N50TBwneNVmeB9TyXbHRLm9CJFGNN+HtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2013 20:07, Guenter Roeck <linux@roeck-us.net> wrote:
>> I got the impression from Guenter Roeck's review, that it doesn't belong there,
>> maybe I was too quick to remove it?
>>
> You'd have to answer the questions I raised in my review if you want it in
> there.

I didn't see a solution at the time. Now I'm thinking arm_pm_restart
can be set later in probe, preventing a crash on load failure, and
maybe it can be unset on unload.

Would you accept a patch for this?

Best regards,
Jonas
