From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Mar 2018 08:56:41 -0300
Subject: PSCI version misdetection
In-Reply-To: <20180312113604.p36tgtsszfunk2qp@lakrids.cambridge.arm.com>
References: <CAOMZO5BbxFTfD_ZsL5zVhHU5Ue_J_YGBW35AwNx=PVpu6WsqwQ@mail.gmail.com>
 <20180312100247.qd2cph56bhypzwp7@salmiak>
 <CAOMZO5BJ2GuqZS=9C6sA=JXif64OcL1gAbaxbpfdCYEGVM7ZTQ@mail.gmail.com>
 <20180312113604.p36tgtsszfunk2qp@lakrids.cambridge.arm.com>
Message-ID: <CAOMZO5Cj=p813_aQMzXPSX3+tqJjsiPhML7N2qQv0JTREWufWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Mar 12, 2018 at 8:36 AM, Mark Rutland <mark.rutland@arm.com> wrote:

> Ok. AFAICT, you need to implement psci_version, and any other mandatory
> PSCI features such as affinity info in your board code, as otherwise the
> default weak implementation is used.

Thanks for your clarification.

I did as suggested and implemeted psci_version (in the same way as ls1021xa):
https://pastebin.com/ZfJkN2HC

and now I get:

[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.

Thanks
