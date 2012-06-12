From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2012 18:12:32 -0300
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
In-Reply-To: <1795608889.2533817.1339535267600.JavaMail.root@advansee.com>
References: <1795608889.2533817.1339535267600.JavaMail.root@advansee.com>
Message-ID: <CAOMZO5BMWJ4fad+YvJskkRLRiOJn1YRMUnCQ5OWen9SSvTc7Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 6:07 PM, Beno?t Th?baudeau
<benoit.thebaudeau@advansee.com> wrote:
> +
> + ? ? ? for (i = 0; i < 20; i++) {

Where does this magic 20 comes from?
