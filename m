From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 05 Nov 2014 21:42:07 +0100
Subject: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <545A8965.2010406@metafoo.de>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>	<CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>	<CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
 <545A8965.2010406@metafoo.de>
Message-ID: <545A8B9F.1090204@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 09:32 PM, Lars-Peter Clausen wrote:
> If it is a generic DAC it should go into drivers/iio/, this will allow code
> sharing and code re-usability. Given the simplicity of the DAC there might
> even be other existing drivers that can be used to control it.

I just had a quick look and I think the M62332 will work out of the box with 
the max517 driver.

- Lars
