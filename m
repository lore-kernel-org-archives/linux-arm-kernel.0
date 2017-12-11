From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 11 Dec 2017 15:33:17 +0100
Subject: [PATCH net-next v5 0/2] net: thunderx: add support for PTP clock
In-Reply-To: <20171211141435.2915-1-aleksey.makarov@cavium.com>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
Message-ID: <CAOFm3uFZS=-HKNhnVDKpstNt6j_TbjMkrPuryO_PXL9P3JSpPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aleksey,

On Mon, Dec 11, 2017 at 3:14 PM, Aleksey Makarov
<aleksey.makarov@cavium.com> wrote:
> This series adds support for IEEE 1588 Precision Time Protocol
> to Cavium ethernet driver.
>
> The first patch adds support for the Precision Time Protocol Clocks and
> Timestamping coprocessor (PTP) found on Cavium processors.
> It registers a new PTP clock in the PTP core and provides functions
> to use the counter in BGX, TNS, GTI, and NIC blocks.
>
> The second patch introduces support for the PTP protocol to the
> Cavium ThunderX ethernet driver.
>
> v5:
> - fix the file headers (add SPDX tags, remove advertisment) (Philippe Ombredanne)

Thank you.

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
