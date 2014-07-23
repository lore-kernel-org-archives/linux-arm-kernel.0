From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Thu, 24 Jul 2014 00:16:22 +0200
Subject: iMX6Q - PCIe
In-Reply-To: <CACUGKYP9w+qUUtp2LRKgD-Dz+2pubFeX82dGQ6tiv2Ji6VgVig@mail.gmail.com>
References: <CACUGKYP9w+qUUtp2LRKgD-Dz+2pubFeX82dGQ6tiv2Ji6VgVig@mail.gmail.com>
Message-ID: <20140724001622.2b475138@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

Le Wed, 23 Jul 2014 14:49:15 -0700,
John Tobias <john.tobias.ph@gmail.com> a ?crit :
> I am trying to use the PCIe on iMX6Q and I am using kernel 3.15.2 and
> AEH-AR9462-LC WFI-BT module.
> 
> The said module were able to detect by the kernel, able to bring up
> the wifi and bluetooth interface and able to scan bluetooth devices as
> as scan wifi.
> 
> When, I run /usr/sbin/wpa_supplicant -Dnl80211 -iwlp1s0
> -c/tmp/wpa_supplicant.conf, I got the following logs (please see
> below). The wpa supplicant keeps trying to connect but for unknown
> reason, it keeps disconnecting.
> 
> 
> Any idea?.
> 
you can try to disable MSI (at least that's how I got ath9k working in
FSL's kernel)

Eric
