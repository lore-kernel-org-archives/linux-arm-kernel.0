From: joe@perches.com (Joe Perches)
Date: Sun, 07 Dec 2014 19:55:12 -0800
Subject: [PATCH 0/20] fix misspelling of current function in string
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1418010912.31745.29.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-12-07 at 20:20 +0100, Julia Lawall wrote:
> These patches replace what appears to be a reference to the name of the
> current function but is misspelled in some way by either the name of the
> function itself, or by %s and then __func__ in an argument list.

At least a few of these seem to be function tracing
style uses that might as well be deleted instead.
