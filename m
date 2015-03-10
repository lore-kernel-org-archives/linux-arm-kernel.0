From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 10 Mar 2015 11:40:46 +0000
Subject: [linux-sunxi] Re: [PATCH] ARM: sun6i: dt: Add new Mele I7 device
In-Reply-To: <54FED277.4040000@redhat.com>
References: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
 <20150303071635.GC4713@lukather> <54F568F8.1040104@redhat.com>
 <20150303082209.GE4713@lukather> <54F5B51F.6030609@redhat.com>
 <20150303135847.GH4911@lukather> <54FED277.4040000@redhat.com>
Message-ID: <1425987646.21353.96.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-10 at 12:16 +0100, Hans de Goede wrote:

> I'm not sure if stdout-path supports aliases

I thought it did but ePAPR section 3.5 says "A string that specifies the
full path to the node" which suggests not, and AFAICT the code doesn't
try to handle alias.

Ian.
