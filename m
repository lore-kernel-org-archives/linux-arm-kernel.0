From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 8 Mar 2017 17:10:25 +0100
Subject: wireless/atmel: remove time_t usage
In-Reply-To: <20170308151340.9D6E360209@smtp.codeaurora.org>
References: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
 <20170308151340.9D6E360209@smtp.codeaurora.org>
Message-ID: <20170308161025.nxz6puyeo3ezwa43@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/2017 at 15:13:40 +0000, Kalle Valo wrote:
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > last_qual never really holds a time. It only holds jiffies. Make it the
> > same type as jiffies.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> The title should start with "atmel:", I can fix that during commit.
> 

If you prefer, I can send a v2

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
