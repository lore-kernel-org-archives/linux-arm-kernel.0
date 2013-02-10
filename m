From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 10 Feb 2013 18:14:34 +0400
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <1360451709-19740-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360451709-19740-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5117AB4A.6060109@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-02-2013 3:15, Ben Dooks wrote:

> Since the new ASID code introduced in b5466f8728527a05a493cc4abe9e6f034a1bbaab

    Plase also specify that commit's summary in parens (or however you like).

> uses 64bit operations, when running in BE mode we see the values in
> mm->context.id swapped around as the lowest word is being stored in
> mm->context.id + 4, instead of + 0.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

WBR, Sergei
