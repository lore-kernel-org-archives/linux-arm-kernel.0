From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 Mar 2013 12:40:55 +0100
Subject: [PATCH] ARM: EXYNOS: change HAVE_SAMSUNG_KEYPAD to
 KEYBOARD_SAMSUNG
In-Reply-To: <014b01ce1acf$63ada580$2b08f080$%kim@samsung.com>
References: <1362566365.16460.173.camel@x61.thuisdomein>
 <014b01ce1acf$63ada580$2b08f080$%kim@samsung.com>
Message-ID: <1362656455.5994.13.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 10:02 +0900, Kukjin Kim wrote:
> BTW, just to use only 8~12 digits of commit ID, "Commit 6b5ab4f4" is
> enough instead of full commit ID.

I used to do that but now I actually prefer to use 40 hex character
strings.

Sure, they're ugly, but so are strings of 10, or 12 hex characters. But
they're easier to use (I can just copy/paste them from the output of,
say, "git log"), I do not have to worry about uniqueness, ever (some
commits now already need at least 8 characters), and some git web
interfaces automagically linkify 40 character hex strings in commit
explanations (which is quite nice).


Paul Bolle
