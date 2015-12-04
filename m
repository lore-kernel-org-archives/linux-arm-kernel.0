From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Fri,  4 Dec 2015 17:31:12 +0000
Subject: Add support for monitoring gpio switches
Message-ID: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver was written to expose a read only interface to a number of
gpios on Chromebooks. These gpios are attached to signals which cause the
firmware on Chromebooks to enter alternative modes of operation and/or
control other device characteristics (such as write protection on flash
devices). It was originally posted as "Add support for monitoring Chrome
OS firmware signals". A request was made to make it more generic.

In addition this patch series provides the required bindings for this to
the peach-pi Chromebook.

This is a new binding, but the driver is based (now some what loosely) on
functionality in the kernel shipped on Chromebooks.
