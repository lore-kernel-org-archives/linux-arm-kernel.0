From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Fri, 24 Oct 2014 14:23:56 +0900
Subject: [PATCH v3 1/3] Add HS-USB device tree support for
 R8A7791/Koelsch/Henninger board
In-Reply-To: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
Message-ID: <5449E26C.7030602@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon-san,

(2014/10/09 2:59), Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20141007-v3.17' tag. Here we add the HS-USB device tree support
> on the R8A7791/Koelsch/Henninger reference boards. The patchset requires the
> USB PHY driver (already merged by Kishon and Greg) and the generic PHY support
> patches for the HS-USB driver posted by Yoshihiro Shimoda in order to work...
> 
> [1/3] ARM: shmobile: r8a7791: add HS-USB device node
> [2/3] ARM: shmobile: koelsch: enable HS-USB
> [3/3] ARM: shmobile: henninger: enable HS-USB

I will also rebase this patch set.

Best regards,
Yoshihiro Shimoda

> WBR, Sergei
> 
