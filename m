From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 4 Jun 2016 16:09:53 +0200
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
In-Reply-To: <20160604140154.GB31801@earth>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <20160604140154.GB31801@earth>
Message-ID: <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-06-16 16:01, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
>> The usb power-supply on the axp22x pmics is mostly identical to the
>> one on the axp20x pmics. One significant difference is that it cannot
>> measure / monitor the usb voltage / current.
>
> Acked-By: Sebastian Reichel <sre@kernel.org>
>
> What's the merge strategy for this patchset?

All of the separate bits can be merged separately without
problems, so Lee can take the 2 mfd patches, you can take
the power-supply patch and Mark Brown can take the regulator
patch.

I believe that that is the best merge strategy.

Regards,

Hans
