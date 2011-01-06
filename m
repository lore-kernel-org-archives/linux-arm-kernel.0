From: carmelo.amoroso@st.com (Carmelo AMOROSO)
Date: Thu, 6 Jan 2011 15:43:33 +0100
Subject: [PATCH 1/2] stackprotector: add stack smashing protector
	generic implementation
In-Reply-To: <20110106141946.GE31708@n2100.arm.linux.org.uk>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
	<4D245D16.5010702@st.com>
	<20110106093940.GA31708@n2100.arm.linux.org.uk>
	<4D25CEB9.7090205@st.com>
	<20110106141946.GE31708@n2100.arm.linux.org.uk>
Message-ID: <4D25D515.9060202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/6/2011 3:19 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 06, 2011 at 03:16:25PM +0100, Carmelo AMOROSO wrote:
>  > Well, SH (in CC) does not have this support. Indeed we posted it
>  > initially to linux-sh only. We got useful feedback from Paul, Mike and
>  > Nicolas suggesting to promote the ARM/SH solution based on the global
>  > __stack_chk_guard variable as a generic solution for all other
>  > architectures. This is why I thought to post to the LKML instead of each
>  > linux-<arch> list.
> 
> Have you thought about posting it to _the_ linux-arch list?
> 
I did not know this list. I'll do. Thanks.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0l1RUACgkQoRq/3BrK1s8a1gCgpSdHez/S8cJ8BM5jVhYH0TKy
84gAnRkeALaLGMoXJqtxdDRL7Xusc6JT
=L6Oj
-----END PGP SIGNATURE-----
