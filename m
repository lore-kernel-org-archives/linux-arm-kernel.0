From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jan 2013 12:02:00 +0100
Subject: [PATCH] pinctrl/nomadik: Add "ste,config" property
In-Reply-To: <50E73559.60508@wwwdotorg.org>
References: <1357316010-677-1-git-send-email-linus.walleij@stericsson.com>
 <50E73559.60508@wwwdotorg.org>
Message-ID: <CACRpkdavE3g0CXc-CFgMeeY0j24N3MHWqE-0eoOwp08aU6QoJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 4, 2013 at 9:02 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> -- ste,input : <0/1/2/3>
>> +- ste,config: Handle of pin configuration node (ste,config = <&in_pu>)
>> +
>> +- ste,input : <0/1/2>
>
> The changes to ste,input and ste,sleep-output look like some unrelated
> change.
>
> I guess the idea of ste,input is quite neat, but ...

I'll squash this whole thing into the patch with the device tree enablement,
so see it as a revieweing convenience that we only send the diff :-)

I'll send out a new version with all issues fixed.

Yours,
Linus Walleij
