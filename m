From: jdelvare@suse.de (Jean Delvare)
Date: Tue, 31 Jan 2017 15:22:49 +0100
Subject: [PATCH] i2c: busses: constify i2c_algorithm structures
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170131152249.07265d1d@endymion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jan 2017 23:36:17 +0530, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> (...)

I have vague memories that I tried to do the same long ago and it
didn't work back then. But I can't no longer remember the details, and
today it seems just fine to do it.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
