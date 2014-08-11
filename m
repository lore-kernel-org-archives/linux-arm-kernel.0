From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Aug 2014 10:31:28 -0300
Subject: Freescale: iMX6Q Sabre SD
In-Reply-To: <CACUGKYM=jPGL+GB1=n9-UQPaphPv4ONQz3Fb5k9-5CA=Zx=1xw@mail.gmail.com>
References: <CACUGKYM=jPGL+GB1=n9-UQPaphPv4ONQz3Fb5k9-5CA=Zx=1xw@mail.gmail.com>
Message-ID: <CAOMZO5BJ6WS-OynZWJLE42pZbrvJ_nMM3qyndYVNsDYbBFWMmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Thu, Aug 7, 2014 at 9:49 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi All,
>
> I have two different board revisions of iMX6Q Sabre SD (Rev C1 / Rev
> A) and (Rev C4 / Rev B).
>
> I am working on PCIe and using the older board, I was able to plug my
> PCIe module, detected by the kernel and able to use it.
>
> The problem right now is the latest board, using the same sd card and
> PCIe module the kernel couldn't detect it. I was getting "imx6q-pcie
> 1ffc000.pcie: phy link never came up" message.
>
> I would like to know if anyone here have encountered similar problem
> and able to fix it?.

I tested on my mx6qsabresd revC4 / rev C and the PCI link is not
detected just like you described.

On my rev B / rev X4 there is no such issue.

I am adding Richard Zhu in Cc in case he knows why revC4 has PCI issues.
