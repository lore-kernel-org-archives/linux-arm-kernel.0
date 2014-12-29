From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Dec 2014 13:09:04 +0300
Subject: [PATCH 2/2] ahci_xgene: Fix the dma state machine lockup for
 the ATA_CMD_PACKET PIO mode command.
In-Reply-To: <CAOHikRAH3rrNw_+_DYx=Fc13BBQMq1Wg0zGyqrxLhNk7TSKqhw@mail.gmail.com>
References: <1418748575-27301-1-git-send-email-stripathi@apm.com>	<1418748575-27301-3-git-send-email-stripathi@apm.com>	<54906CF0.9010908@cogentembedded.com>	<CAOHikRCRHPnVAziU8jwD9gGFODyt_5DpL1dm7Eb8uGA-WOfxOw@mail.gmail.com>	<5491BE11.4070500@cogentembedded.com>
 <CAOHikRAH3rrNw_+_DYx=Fc13BBQMq1Wg0zGyqrxLhNk7TSKqhw@mail.gmail.com>
Message-ID: <54A12840.90703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/29/2014 8:35 AM, Suman Tripathi wrote:

>          This patch addresses the issue with ATA_CMD_PACKET pio mode
>          command for enumeration and device detection with ATAPI devices.It is the
>          same issue as in patch


>     Ugh, HTML... Please stick to plain text when posting to the
> 'vger.kernel.org <http://vger.kernel.org/>' mailing lists (HTML mails are
> supposed to be ignored).

>     www.spinics.net/lists/linux-____ide/msg49092.html
>     <http://www.spinics.net/lists/linux-__ide/msg49092.html>
>          <http://www.spinics.net/lists/__linux-ide/msg49092.html
>     <http://www.spinics.net/lists/linux-ide/msg49092.html>>

> This is something strange. I posted it in plain text only. Because when I do
> show original of the patch in gmail, it shows me the plaintext.
> Please help me out to figure the issue. I saw many other patches referred in
> the same way. I am sending the patch through git-send-email  that sends in
> plain text format only,

    The patch was OK, but your replies do use HTML (as well as plain text).

>          Signed-off-by: Suman Tripathi <stripathi@apm.com
>     <mailto:stripathi@apm.com> <mailto:stripathi@apm.com
>     <mailto:stripathi@apm.com>>>

> --
> Thanks,
> with regards,
> Suman Tripathi

MBR, Sergei
