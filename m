From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Mon, 7 Jul 2014 19:27:22 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
References: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
Message-ID: <CAB8gEUv52mjpAuYRKhv8_VuAwt9Uog5eD2jn45gnyqcd+cXv8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, correcting typo:

- 3.13.9 (issue exists)
- 3.10.24 (issue does NOT exist)
- 3.13.5 (issue does NOT exist)

On Mon, Jul 7, 2014 at 7:20 PM, Maggie Mae Roxas
<maggie.mae.roxas@gmail.com> wrote:
> Hi Thomas,
> Good day.
>
> We have previously discussed before on Armada 370 ethernet issues
> (resolved via your suggestion/patches).
>
> We just found out recently that ethernet (SGMII) connection encounters
> "No buffer space available" error during continuous ping to other
> nodes in the same network (ie, even ping to the server). It is
> frequently around the 17th packet.
> # Please see attached log (ping_error.txt) for more info.
>
> Here are the details:
>
> Processor: Marvell Armada 370 88F6707
> Ethernet module: Marvell 88E1512
> Board: Custom
> Kernel versions tried:
> - 3.13.9 (issue exists)
> - 3.10.24 (issue does NOT exist)
> - 3.13.9 (issue does NOT exist)
> U-Boot versions tried: 2013_Q1 and 2013_Q3 from Marvell extranet
>
> Some more important notes:
> - This does not happen in wlan connections.
> - This happens in 10, 100 and 1000Mbps connections.
>
> Is there a known issue for this?
>
> As always, thank you very much.
>
> Regards,
> Maggie Roxas
