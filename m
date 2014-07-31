From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 31 Jul 2014 13:48:16 +0300
Subject: [PATCH 5/8] of: Add Tegra124 EMC bindings
In-Reply-To: <53D7C276.2080204@wwwdotorg.org>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>	<1405088313-20048-6-git-send-email-mperttunen@nvidia.com>	<CAL1qeaGHfjQhLHvgzt85hmbuY4FOG5-k=f80=CNvzPDEgi9_6w@mail.gmail.com>	<53CD860B.7030800@wwwdotorg.org>	<CAL1qeaHtGQxCO3cGdeCRUYuk6mxei6z1B63-iZdBECEbFqGhHw@mail.gmail.com>	<53CE9514.1050903@wwwdotorg.org>
 <CAL1qeaEkL+mxb0S4JhQbXBjyNyKJndffTSjMaAFQD6ooDJPd+Q@mail.gmail.com>
 <53CEA093.6060106@wwwdotorg.org> <53D75B90.7050501@nvidia.com>
 <53D7C276.2080204@wwwdotorg.org>
Message-ID: <53DA1EF0.7060207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/14 18:49, Stephen Warren wrote:
> On 07/29/2014 02:30 AM, Mikko Perttunen wrote:
>> Looks like the TRM doesn't document this either. I'll add an option
>> ("nvidia,short-ram-code" ?) for the next version.
>
> Using the 2-bit RAM code field as the RAM code is normal operation, so I
> wouldn't call this "short".
>
> Using the 2-bit boot device code field as extra RAM code bits is
> non-standard.
>
> I would suggest nvidia,use-4-bit-ram-code or
> nvidia,use-boot-device-code-as-ram-code-msbs(!) as the property.

Sure.

>
> I see that the TRM implies the whole 4-bit field is RAM code, rather
> than there being 2 separate 2-bit fields for RAM code and boot device
> code. Can you please file a bug against the TRM to document this
> correctly? (The details of which bits are which are visible on the
> Jetson TK1 schematics for example).

Yes, I'll file a bug.

- Mikko
