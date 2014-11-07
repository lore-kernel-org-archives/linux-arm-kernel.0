From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Nov 2014 14:55:09 +0100
Subject: [PATCH v2 06/11] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <1415203287-21517-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141107135509.GD4068@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We probabyl should start making sure we have a commit log for every
patches ;)

On 05/11/2014 at 17:01:22 +0100, Boris Brezillon wrote :
> +Child chip-select (cs) nodes contain the memory devices nodes connected to
> +such as NOR (e.g. cfi-flash) and NAND.
> +There might be board specific devices like FPGAs.
> +You'll define you device requirements in these child nodes.
                 your


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
