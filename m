From: corbet@lwn.net (Jonathan Corbet)
Date: Fri, 27 Feb 2015 14:55:20 -0700
Subject: [PATCH] Documentation: arm: Update for DT-only platforms
In-Reply-To: <1423018169-31221-1-git-send-email-gregory.0xf0@gmail.com>
References: <1423018169-31221-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <20150227145520.5f7032a9@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  3 Feb 2015 18:49:26 -0800
Gregory Fong <gregory.0xf0@gmail.com> wrote:

> The documentation specified that a machine type is mandatory and made
> that assumption in a few places.  However, for DT-only platforms, the
> current advice is that no machine type should be registered, so update
> accordingly.

It seems nobody has complained about this, so I've just applied it to the
docs tree.

Thanks,

jon
