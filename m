From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 11:08:38 -0800
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
In-Reply-To: <20130211185221.GR4801@atomide.com>
References: <20130211170616.73fd9fd30bb10c27a698ad4d@canb.auug.org.au>
 <20130211185221.GR4801@atomide.com>
Message-ID: <CAOesGMi5xCahJ=5emwxiXeKEZkK4yhctcTddPZNQXO5wzcdQwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 10:52 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> [130210 22:11]:
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> arch/arm/mach-omap2/usb-host.c between commit 8a89e93237e1 ("mfd:
>> omap-usb-host: Consolidate OMAP USB-HS platform data") from the mfd tree
>> and commit c1d1cd597fc7 ("ARM: OMAP2+: omap_device: remove obsolete
>> pm_lats and early_device code") from the arm-soc tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
>
> Thanks again.
>
> Samuel, up to you, but I suggest you just drop these patches for
> now if still possible unless other patches are based on these.

Yes, as I replied on the original patch series last night, please sort
this out so we can avoid these nagging merge conflicts. Tony's steps
in the previous email is the right way to handle these kind of things.


-Olof
