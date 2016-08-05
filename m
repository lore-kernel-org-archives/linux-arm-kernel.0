From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 5 Aug 2016 21:28:59 +0300
Subject: [PATCH 0/2] Add R8A7792 DU support
In-Reply-To: <4031442.KeMCTMarLN@wasted.cogentembedded.com>
References: <4031442.KeMCTMarLN@wasted.cogentembedded.com>
Message-ID: <4a413062-d7f4-166a-f915-01803bddf441@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2016 09:24 PM, Sergei Shtylyov wrote:

>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160725-v4.7-rc7' tag. We're adding the R8A7792 DU clocks and
> device nodes. They have been tested on the Blanche board -- I'm not posting the
> Blanche patch only because it also has some strange interaction with the
> Ethernet chip, so that NFS root can't work anymore...

    Forgot to mention that the patch #2 depends on the R8A7792 DU driver patch 
posted last night.

MBR, Sergei
