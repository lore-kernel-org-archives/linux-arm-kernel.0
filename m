From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 2 Jan 2015 16:52:06 +0100
Subject: [PATCH resend v3 0/2] mmc: Add SDIO function devicetree subnode
 parsing
In-Reply-To: <1404119245-5839-1-git-send-email-hdegoede@redhat.com>
References: <1404119245-5839-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAPDyKFrTcJw0aZ-V399jJzCmi-6nqduUFV02s-bN-oDAOwVA5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 at 11:07, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is a resend of 3 of my submission of Sascha Hauer's
> "mmc: Add SDIO function devicetree subnode parsing" patch.
>
> Can we please get some movement on these patches, either a review specifying
> why this cannot go upstream, or else queuing it up for next / 3.17 ?
>
> Changes since v1:
> - Submit as a stand-alone patch-set, rather then as part of a larger oob irq
>   support patchset crossing multiple subsystems
> - Add a patch to document the already existing practice of using slot subnodes
> - Split of the dt bindings documentation for sdio-func child nodes into its
>   own patch
> - Add a preparation patch, setting slot_no where relevant
> - And finally the "Add SDIO function devicetree subnode parsing" patch itself
>   has been modified to look for the sdio function childnodes under a slot node
>   instead of directly under the host node
>
> Changes since v2:
> - Drop the slot subnodes again, and drop the 2 slot subnodes patches
>
> Regards,
>
> Hans

So after quite a delay (sorry about that!!), I decided to apply this
patchset for my next branch.

Only a minor trivial conflict showed up on patch2. Also I took the
liberty to change the prefix of patch 1 into only "mmc".

Kind regards
Uffe
