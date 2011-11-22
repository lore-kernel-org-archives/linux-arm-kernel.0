From: consul.kautuk@gmail.com (kautuk.c @samsung.com)
Date: Tue, 22 Nov 2011 13:19:32 -0500
Subject: [PATCH 1/1 v4] arm: fault.c: Port OOM changes into do_page_fault
In-Reply-To: <CAFPAmTRK6OubP5u_YwcRyyN6vujgqwBaq8-JobdnnYmjEE3Y+g@mail.gmail.com>
References: <1321181347-4391-1-git-send-email-consul.kautuk@gmail.com>
 <CAFPAmTRK6OubP5u_YwcRyyN6vujgqwBaq8-JobdnnYmjEE3Y+g@mail.gmail.com>
Message-ID: <CAFPAmTSnUzdVagN6LzdsUnk1x-vTM3d5iE3aZd4HHQk=bhr7vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got some time to do some more self-review and I spotted one
redundant piece of code in this patch
related to VM_FAULT_ERROR handling.

So I have resent as version 5.

Uh.. is there something fundamentally wrong with this patch ?
