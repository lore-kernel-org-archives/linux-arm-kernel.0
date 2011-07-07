From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 13:11:29 +0200
Subject: [PATCH v4 0/3] ARM: CSR: Adding CSR SiRFprimaII platform
In-Reply-To: <1310020616-27856-1-git-send-email-bs14@csr.com>
References: <1310020616-27856-1-git-send-email-bs14@csr.com>
Message-ID: <201107071311.29643.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Barry Song wrote:
> Changelogs:
> -v4:
> v3 got "Reviewed-by: Arnd Bergmann <arnd@arndb.de>"
> stopping the 0xffffffff madness for IO_SPACE_LIMIT
> fix .map_io compiling issue in the 1st patch
> fix set_next_event in timer.c
> rename GPU, USB, multimedia and SATA nodes in DTS
> delete redundant 0x in DTS

Note that when you get a 'Reviewed-by', 'Acked-by' or 'Tested-by'
reply to one of your mails, you should add that in the patch
changelog below your own 'Signed-off-by' in order to document
it for the future. This ususally still holds true when you make
further changes, just not when rewriting major parts of the patch.

For the Signed-off-by list, that should normally include only the
people that have handled the specific patch, it doesn't imply
authorship. Having seven people listed as Signed-off-by seems a bit
strange in this context, but there is no clear rule against it.
I would probably use 'Acked-by' or plain 'Cc' in the changelog for
some of the people, depending in what way they were involved.

At the least, you should have 'Signed-off-by' the person that wrote
most of the code, followed by the person that sends the patch at
the bottom of the list (as you did correctly).

	Arnd
