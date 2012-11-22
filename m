From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Nov 2012 11:45:17 +0100
Subject: [PATCHv2] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the
 device tree
In-Reply-To: <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
References: <20121120144322.GE4882@S2100-06.ap.freescale.net>
 <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50AE023D.3000406@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Shawn,

Le 20/11/2012 15:33, Maxime Ripard a ?crit :
> Add the GPIO expander found on the i2c1 bus, behind the muxer to
> the device tree.
> 
> This gpio expander will be used to get tachymeters values and data 
> ready interruptions from the nuvoton NAU7802 ADCs.

If you're ok with it, I'd really like for that patch to be in 3.8.
Is this version ok, or do you have any additional comments I could
address?

Thanks,
Maxime

- -- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCuAjsACgkQGxsu9jQV9naCFwCfXjxLa0qLRx2ThFDFLSC8bKAk
hHsAnjYIC7xtbHzZW27GGy3TdfZO5O5M
=0dLl
-----END PGP SIGNATURE-----
