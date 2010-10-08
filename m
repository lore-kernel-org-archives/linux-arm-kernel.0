From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Fri, 8 Oct 2010 05:26:00 -0700 (PDT)
Subject: [PATCH v2] i.MX35: use the correct IIM register to get CPU
	revision
In-Reply-To: <1286525909-30956-1-git-send-email-eric@eukrea.com>
Message-ID: <867013.82798.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

--- On Fri, 10/8/10, Eric B?nard <eric@eukrea.com> wrote:
...
> instead of using ROM_SI_REV use IIM's
> Silicon Revision register
> as described in :
> - Reference Manual 29.3.3.10
> - RM Errata 29.3.3.9.13
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

Yes, this is the preferred method for silicon detection on MX35.

Thanks,

Fabio Estevam


      
