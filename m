From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Nov 2014 10:40:36 +0000
Subject: [PATCH] ARM: mm: fix size rounding-down of arm_add_memory()
In-Reply-To: <CAMuHMdXo9HCTJNi8ObutwcUZiXyfyta5+McoA9UaEhueh-6gRg@mail.gmail.com>
References: <1402025567-18021-1-git-send-email-yamada.m@jp.panasonic.com>
 <20140801213719.D537.AA925319@jp.panasonic.com>
 <CAMuHMdXjX5AJT9fVja+GCTV4Zxp==xTe8ZFT8_uf=aFDYZ9+Jw@mail.gmail.com>
 <CAMuHMdXo9HCTJNi8ObutwcUZiXyfyta5+McoA9UaEhueh-6gRg@mail.gmail.com>
Message-ID: <20141127104036.GO3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:36:31AM +0100, Geert Uytterhoeven wrote:
> Any chance we can get this fix applied?

As ever, if it ends up in the patch system, then I'll apply it, otherwise
it very quickly falls off of my radar due to the shere volume of email I
receive.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
