From: schwab@suse.de (Andreas Schwab)
Date: Thu, 31 Jul 2014 09:18:04 +0200
Subject: Missing module license in arm_big_little
Message-ID: <mvmmwbqateb.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$ dmesg | grep arm_big_little
[   22.596727] arm_big_little: module license 'unspecified' taints kernel.
[   22.608717] arm_big_little: Unknown symbol cpufreq_register_driver (err 0)
[   22.615565] arm_big_little: Unknown symbol dev_pm_opp_init_cpufreq_table (err 0)
[   22.622927] arm_big_little: Unknown symbol cpufreq_unregister_driver (err 0)
[   22.629935] arm_big_little: Unknown symbol clk_set_rate (err 0)
[   22.648419] arm_big_little: Unknown symbol cpufreq_table_validate_and_show (err 0)
[   22.655943] arm_big_little: Unknown symbol cpufreq_generic_attr (err 0)
[   22.662551] arm_big_little: Unknown symbol dev_pm_opp_free_cpufreq_table (err 0)
[   22.669886] arm_big_little: Unknown symbol clk_get_rate (err 0)
[   22.675777] arm_big_little: Unknown symbol get_cpu_device (err 0)
[   22.681840] arm_big_little: Unknown symbol cpu_topology (err 0)
[   22.687722] arm_big_little: Unknown symbol cpufreq_generic_frequency_table_verify (err 0)

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
