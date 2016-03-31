From: carlo@caione.org (Carlo Caione)
Date: Thu, 31 Mar 2016 11:41:29 +0200
Subject: [PATCH v3 2/2] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <CACRpkdaFrM9ccDAbb0ks3_GFPPZvmLDnKY30MCRbpzemYhVFvg@mail.gmail.com>
References: <1458724440-32228-1-git-send-email-carlo@caione.org>
 <1458724440-32228-3-git-send-email-carlo@caione.org>
 <CACRpkdaFrM9ccDAbb0ks3_GFPPZvmLDnKY30MCRbpzemYhVFvg@mail.gmail.com>
Message-ID: <CAOQ7t2YZ5iNzXKGr-ucq3cH1nEEuHjmNY+756Y3KbjsaBtPwTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 11:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Mar 23, 2016 at 10:14 AM, Carlo Caione <carlo@caione.org> wrote:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Fix pin controller documentation introducing the new compatibles for
>> the pinctrl drivers specific for aobus / cbus.
>>
>> This is needed because we have changed the pin controller driver: we
>> have now a single specialized pinctrl driver / compatible for each bus
>> the controller is attached to, instead of one single driver dealing with
>> all the controllers we have on different buses.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> This patch applied to the pinctrl tree with the tags.
>
> It is just documentation so it's obviously not an urgent
> fix.
>
> Please merge patch 1/2 through the ARM SoC tree.

Hey Linus,
I already submitted DT fix and Documentation in the PR to arm-soc here
http://www.spinics.net/lists/arm-kernel/msg493680.html

Cheers,

-- 
Carlo Caione
