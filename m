From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Sep 2014 23:40:10 -0700
Subject: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140915064010.GD26649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
> When MADT is parsed, print GIC information to make the boot
> log look pretty.

If you do this for prettiness, having an example output in the commit
message would be a nice touch.

The question is why it's needed though? Do we really need all this verbose
information in dmesg when it could be found out in other ways instead?

x86 is notoriously verbose in some of these aspects, I'm not sure it's
something we need to mimic here?


-Olof
