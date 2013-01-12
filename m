From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 12 Jan 2013 16:07:24 +1300
Subject: [PATCH 0/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <20130111215659.GA16521@quad.lixom.net>
References: <1357935162-7672-1-git-send-email-linux@prisktech.co.nz>
 <20130111215659.GA16521@quad.lixom.net>
Message-ID: <1357960044.8515.0.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I suggest that you split off the last three (and rebase them to be
> independent), and apply them to a multiplatform branch for vt8500. Then the
> last one is a soc branch that goes on top of the multiplatform branch (i.e. you
> build it on top of multiplatform). That way we can pull in the multiplatform
> changes together with those for other platforms, and then take the wm8{7,8}50
> branch goes in with the other new-soc support from other platforms.
> 
> Does that make sense? I'll be happy to provide more explanation if it doesn't.
> 
> -Olof

I think I understand - pull requests to follow.

Tony P
