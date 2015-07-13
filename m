From: gkurz@linux.vnet.ibm.com (Greg Kurz)
Date: Mon, 13 Jul 2015 11:24:08 +0200
Subject: [PATCH] KVM: Add Kconfig option to signal cross-endian guests
In-Reply-To: <1436428145-29823-1-git-send-email-thuth@redhat.com>
References: <20150707195012-mutt-send-email-mst@redhat.com>
 <1436428145-29823-1-git-send-email-thuth@redhat.com>
Message-ID: <20150713112408.060164e1@bahia.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  9 Jul 2015 09:49:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The option for supporting cross-endianness legacy guests in
> the vhost and tun code should only be available on systems
> that support cross-endian guests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
