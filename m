From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Jul 2010 18:54:41 +0300
Subject: [PATCH 04/15] mmc: support embedded data field in mmc_host
In-Reply-To: <AANLkTilfjBIbylUDKlTGiEC_U6pJnkC6HoENOzK2eFFq@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-5-git-send-email-ohad@wizery.com>
	<AANLkTilfjBIbylUDKlTGiEC_U6pJnkC6HoENOzK2eFFq@mail.gmail.com>
Message-ID: <AANLkTinPL8tJTzb5fr2QNy8h1ANtTQZkrwQpUlx9B6Tr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 6, 2010 at 6:49 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> Hm, do we really need a Kconfig option just for a single pointer? It
> only saves sizeof(void *) bytes per host, but adds rather confusing
> config option for users and some ifdef complexity.

No strong feelings about it, I can remove that if preferred.

>
