From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 10:11:20 -0400 (EDT)
Subject: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <20140915064010.GD26649@localhost>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
 <20140915064010.GD26649@localhost>
Message-ID: <110210623.13993550.1410790280170.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

How about having it verbose in the initial implementation (in case there are any fun times bringing up early systems) and then revisiting this? x86 is very verbose but it can be helpful.

Jon.

-- 
Computer Architect | Sent from my #ARM Powered Mobile device

On Sep 15, 2014 12:34 AM, Olof Johansson <olof@lixom.net> wrote:
>
> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote: 
> > When MADT is parsed, print GIC information to On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
> When MADT is parsed, print GIC information to make the boot
> log look pretty.

If you do this for prettiness, having an example output in the commit
message would be a nice touch.

The question is why it's needed though? Do we really need all this verbose
information in dmesg when it could be found out in other ways instead?

x86 is notoriously verbose in some of these aspects, I'm not sure it's
something we need to mimic here?


-Olof
