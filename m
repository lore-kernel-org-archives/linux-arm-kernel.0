From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Mon, 13 Apr 2015 15:34:29 -0700
Subject: [RFC PATCH] ARM: debug: Add prompt for FRAME_POINTER to
 Kconfig.debug
In-Reply-To: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
References: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CADtm3G6dXsoc5HyiQcZ9zHGD_h2y1Uo5F4=tz7KGDZt8vtRDTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 8, 2015 at 5:04 PM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> Without a prompt string, it is impossible to disable FRAME_POINTER on
> ARM. It will simply set the default value anytime you run 'make'.

NAK'ing myself.  You should not disable both FRAME_POINTER and
ARM_UNWIND on ARM, as a working unwind_frame() is required in several
places.  Sorry for the noise.
