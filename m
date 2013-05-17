From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 18 May 2013 02:23:37 +0400
Subject: [PATCH v2 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <519235D7.1050706@cogentembedded.com>
References: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
 <1368499171-22427-3-git-send-email-horms+renesas@verge.net.au>
 <9708378.xkqng7A9dx@avalon> <519235D7.1050706@cogentembedded.com>
Message-ID: <5196ADE9.2080308@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/14/2013 05:02 PM, Sergei Shtylyov wrote:

>
>>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> Is there any ongoing work on DT bindings for sh-eth ?
>
>    At least there was -- by Nobuhiro Iwamatsu. I don't think 
> converting platform data to DT properties makes sense since sh_eth 
> have some procedural platform data. I also don't think working on DT 
> makes sense until the driver is cleaned up of all its #ifdef'ery (that 
> work is partly being done by Nobuhiro and I'm planning to start the 
> big #ifdef cleanup this week).

     Alas, not this week apparently as my management has shifted 
priorities thrice this week. So maybe late next week now...

WBR, Sergei
