From: robh@kernel.org (Rob Herring)
Date: Wed, 16 Apr 2014 08:44:02 -0500
Subject: [PATCH] ARM: mach-mxs: readd just removed select CLKSRC_OF
In-Reply-To: <20140416083447.GB11602@dragon>
References: <1397546439-25153-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20140416083447.GB11602@dragon>
Message-ID: <CAL_JsqJ0fQwLtZkmYRVmXmCV6v2KkUrO=iMimBa24aN++qc3Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 3:34 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Apr 15, 2014 at 10:20:39AM +0300, Lauri Hintsala wrote:
>> MXS based apx4devkit doesn't boot with latest Linux v3.15-rc1
>> because commit ddb902cc34593ecb88c368f6e15db3cf829c56fe removed
>> "select CLKSRC_OF" from the machine config.
>>
>> CC: linux-arm-kernel at lists.infradead.org
>> CC: Rob Herring <robh@kernel.org>
>> CC: Shawn Guo <shawn.guo@linaro.org>
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> Hi, arm-soc folks,
>
> I just sent a batch of fixes for 3.15 off my hand to you guys.  Can you
> please apply this fix directly on arm-soc for 3.15?  Thanks.

NAK. This needs to be fixed on for all multi-platform and I just sent
a patch doing that.

Rob
