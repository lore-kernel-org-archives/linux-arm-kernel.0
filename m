From: pmenzel@molgen.mpg.de (Paul Menzel)
Date: Tue, 29 May 2018 16:53:04 +0200
Subject: Status of aspeed-bmc-opp-firestone (IBM S822LC)
Message-ID: <287c6a85-65ba-5782-e532-d17d517614f5@molgen.mpg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Joel, dear Linux folks,


We have an IBM S822LC system (Firestone(?)). Building of OpenBMC 
currently fails, as the not everything was ported from dev-4.10 to 
dev-4.13 [1], and therefore a file cannot be found.

Looking at upstream Linux, there are BMCs for Power 8 systems, like 
Palmetto, included.

```
$ ls arch/arm/boot/dts/aspeed-bmc-opp-*
arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
```

Does somebody know, why Firestone was not upstreamed? Is somebody 
working on upstreaming it? If not, do you have scripts to port such 
work? Manually cherry-picking stuff in this case is hard, as there are a 
lot of conflicts.


Kind regards,

Paul


[1]: https://github.com/openbmc/openbmc/issues/3206

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/85b5f96e/attachment-0001.p7s>
