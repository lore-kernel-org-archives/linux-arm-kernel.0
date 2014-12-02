From: w@1wt.eu (Willy Tarreau)
Date: Tue, 2 Dec 2014 07:56:31 +0100
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUuE8GK=Pab1agvJS5y=+fKLwhJ4LYXFpxOd-Frtke5d1w@mail.gmail.com>
References: <20140723061659.GE30488@1wt.eu>
 <CAB8gEUtO=K-mjie6czsf-9ao1cxiMAV2ScbgUnf+XxqjEfOUvg@mail.gmail.com>
 <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
 <20141201072802.GB21731@1wt.eu>
 <CAB8gEUsQ8nSNwB7vpZHBkELEBX2sN1QdWvujBGYQJY9dtCzgww@mail.gmail.com>
 <20141201092851.GA22304@1wt.eu> <20141201103221.6268b811@free-electrons.com>
 <20141201095815.GA7949@1wt.eu>
 <CAB8gEUuW-r8oY=+ku+Cy4ZBKBvO9rF+QApn=WxR3nZFaSoCvTg@mail.gmail.com>
 <CAB8gEUuE8GK=Pab1agvJS5y=+fKLwhJ4LYXFpxOd-Frtke5d1w@mail.gmail.com>
Message-ID: <20141202065631.GA22506@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maggie,

On Tue, Dec 02, 2014 at 12:09:05PM +0800, Maggie Mae Roxas wrote:
> Hi Willy, Thomas,
> Good day.
> 
> This is just to confirm that the patch Willy sent yesterday, patched
> to 3.13.9 alone, resolves these issues:
> - "No buffer space available" around 17th packet
> - Low throughput on iperf as client (ie, ~130 Mbits/s on 1000 Mbits/s)
> - Kernel crash
> 
> We confirmed it after quite some testing.
> # Full logs at:
> # as iperf client: https://app.box.com/s/5pzh753dmmnqt4q8s5iy
> # as iperf server: https://app.box.com/s/t9ohxrcphpmnfer9dtj9
> 
> Thank you very much for your assistance again!!! :)

thanks for your valuable feedback, I'll add your tested-by and will
send it to netdev for inclusion before I switch to something else
and forget again!

Willy
