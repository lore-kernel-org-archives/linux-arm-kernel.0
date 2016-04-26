From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 26 Apr 2016 21:27:17 +0300
Subject: [PATCH] ARM: dts: at91: VInCo: fix phy reset gpio flag
In-Reply-To: <20160426.131750.433048061726795876.davem@davemloft.net>
References: <570BF481.9070903@cogentembedded.com>
 <1461666272-10107-1-git-send-email-nicolas.ferre@atmel.com>
 <20160426.131750.433048061726795876.davem@davemloft.net>
Message-ID: <571FB305.4060304@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2016 08:17 PM, David Miller wrote:

>> I plan to queue this patch through arm-soc for 4.7.
>
> Ok.

    How about this patch going thru your net-next repo instead?
I'd like to keep the kernel bisectable... if my phylib/macb patches get merged 
earlier than this one, that board would be broken...

MBR, Sergei
