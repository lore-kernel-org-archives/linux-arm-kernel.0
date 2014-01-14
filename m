From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 14 Jan 2014 09:48:53 -0700
Subject: AArch64 kernel image decompression
In-Reply-To: <201401140714.52400.arnd@arndb.de>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
 <CAOesGMi_QY6z_3QSdAs-3JaEUufgymJg=kiqpb9D6RNNjZF5sA@mail.gmail.com>
 <201401140714.52400.arnd@arndb.de>
Message-ID: <52D56A75.20505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 11:14 PM, Arnd Bergmann wrote:
...
> Note that uImage is fundamentally incompatible with multiplatform kernels,
> since it hardcodes the load address in the image file.

FWIW, with "mkimage -T kernel_noload", that's no longer true.
