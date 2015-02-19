From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 19 Feb 2015 19:01:59 +0100
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
Message-ID: <1424368919.13604.9.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2015-02-19 at 19:38 +0200, Pantelis Antoniou wrote:

> Having to boot and tweak the bootloader settings to select the correct
> dtb (even if it?s present on the flash medium) takes time and is
> error-prone.

Dedicate a set of GPIO for board/PCB revision detection (it only costs a
few resistors connected to VCC or GND), then use that information to
choose the correct DTB.

-- 
Maxime
