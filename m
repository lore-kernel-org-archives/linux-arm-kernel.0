From: hjk@hansjkoch.de (Hans J. Koch)
Date: Thu, 22 Dec 2011 22:19:48 +0100
Subject: [PATCH 0/4] arm: Remove Telechips subarchitecture
Message-ID: <20111222211948.GA1201@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately, nobody is interested in having support for Telechips' SoCs in
mainline. With neither feedback nor support from anywhere, I am not willing
to maintain this any longer.

Russell requires subarchs to be up-to-date and maintainers to do their work
to prevent their subarchs from bit-rotting. That is completely the right
thing to do.

For me, the only possible course of action is to completely remove the
whole Telechips subarchitecture. I'll reply to this mail with a series of
four patches that does this.

Thanks,
Hans
