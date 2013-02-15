From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 20:24:02 +0100
Subject: [PATCH 1/2] pinctrl: tegra: add clfvs function to Tegra114 support
In-Reply-To: <511A8FCD.5080402@wwwdotorg.org>
References: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
 <5119829C.20400@wwwdotorg.org> <511A6EE8.7010301@nvidia.com>
 <511A8A46.2010701@nvidia.com> <511A8FCD.5080402@wwwdotorg.org>
Message-ID: <CACRpkdYw1_uWrnNEPEmNHcJgbUv=pe6PEK3PCutgQF6rfQTx4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 7:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/12/2013 11:30 AM, Rhyland Klein wrote:

>> After looking, the devicetree binding doc don't seem to list the valid
>> functions. This change adds a function, and the other groups similar
>> (blink, cec, ...) don't seem to be listed either. Is there something
>> else that should be changed in the binding doc that I am missing?
>
> Oh right, so they don't. They really should though, so could you please
> file an internal bug to get the list of function added.
>
> If there are groups missing from the list of valid groups, they should
> be added too.
>
> However, all that is unrelated to this patch series, so consider my
> previous Reviewed-by to apply to the series as-is.
>
> LinusW, I assume you will apply patch 1/2 to your pinctrl tree, and I'll
> apply patch 2/2 to the Tegra tree later.

OK I've picked this as one of my last things before the merge
window!

Thanks,
Linus Walleij
