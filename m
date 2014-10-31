From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 31 Oct 2014 14:49:00 +0100
Subject: [PATCHv2 3/3] ARM: mvebu: add missing of_node_put() call in
 coherency.c
In-Reply-To: <1414423955-5933-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414423955-5933-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5453934C.4080604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 27/10/2014 16:32, Thomas Petazzoni wrote:
> There is a missing of_node_put() to decrement the device_node
> reference counter after a of_find_matching_node() in coherency_init().

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
