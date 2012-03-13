From: pintu.k@samsung.com (PINTU KUMAR)
Date: Tue, 13 Mar 2012 04:53:46 +0000 (GMT)
Subject: [INFO] : Hibernation and Resume between 2 similar devices
Message-ID: <28119509.96581331614425960.JavaMail.weblogic@epml27>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I am just curious to know if it is possible to "Hibernate in one device" and "Resume the hibernated image from another similar device".

Suppose, I have 2 exactly similar device (Laptop or mobile phone) with me.
At one time I will be working on only one device at a time.
Suppose I started my work on "Device 1"  with few opened application and later I wanted to switch to "Device 2" which is exactly similar to Device 1.
I thought to hibernate (suspend to disk) the Device 1 and store the hibernated image as a swap file and later transfer to sd card.
Then take of the sd card from Device 1 and put it into Device 2.
Copy the swap file from sd card to Device 2 in some swap partition.
Then reboot the Device 2 to Resume from this swap file.
I will get back my Device 1 content in Device 2.

Hope this is possible ?

Any comments.....

Regards,
Pintu
